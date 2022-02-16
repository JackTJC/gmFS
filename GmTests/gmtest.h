//
//  Header.h
//  GmSSLTests
//
//  Created by bytedance on 2022/2/16.
//

#ifndef Header_h
#define Header_h
# include <openssl/engine.h>
# include <string.h>

RAND_METHOD fake_rand;
const RAND_METHOD *old_rand;
static const char rnd_seed[] =
    "string to make the random number generator think it has entropy";
static const char *rnd_number = NULL;

static inline int fbytes(unsigned char *buf, int num)
{
    int ret = 0;
    BIGNUM *bn = NULL;

    if (!BN_hex2bn(&bn, rnd_number)) {
        goto end;
    }
    if (BN_num_bytes(bn) > num) {
        goto end;
    }
    memset(buf, 0, num);
    if (!BN_bn2bin(bn, buf + num - BN_num_bytes(bn))) {
        goto end;
    }
    ret = 1;
end:
    BN_free(bn);
    return ret;
}

static inline int change_rand(const char *hex)
{
    if (!(old_rand = RAND_get_rand_method())) {
        return 0;
    }

    fake_rand.seed        = old_rand->seed;
    fake_rand.cleanup    = old_rand->cleanup;
    fake_rand.add        = old_rand->add;
    fake_rand.status    = old_rand->status;
    fake_rand.bytes        = fbytes;
    fake_rand.pseudorand    = old_rand->bytes;

    if (!RAND_set_rand_method(&fake_rand)) {
        return 0;
    }

    rnd_number = hex;
    return 1;
}

static inline int restore_rand(void)
{
    rnd_number = NULL;
    if (!RAND_set_rand_method(old_rand))
        return 0;
    else    return 1;
}

int sm3test(void);
int sm2test(void);
int sm9test(void);
int zuctest(void);

#endif /* Header_h */
