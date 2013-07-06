/*    inline_invlist.c
 *
 *    Copyright (C) 2012 by Larry Wall and others
 *
 *    You may distribute under the terms of either the GNU General Public
 *    License or the Artistic License, as specified in the README file.
 */

#if defined(PERL_IN_UTF8_C) || defined(PERL_IN_REGCOMP_C) || defined(PERL_IN_REGEXEC_C)

#define INVLIST_LEN_OFFSET 0	/* Number of elements in the inversion list */

/* This is a combination of a version and data structure type, so that one
 * being passed in can be validated to be an inversion list of the correct
 * vintage.  When the structure of the header is changed, a new random number
 * in the range 2**31-1 should be generated.  Then, if an auxiliary program
 * doesn't change correspondingly, it will be discovered immediately */
#define INVLIST_VERSION_ID_OFFSET 1
#define INVLIST_VERSION_ID 1511554547

#define INVLIST_ZERO_OFFSET 2	/* 0 or 1 */
/* The UV at position ZERO contains either 0 or 1.  If 0, the inversion list
 * contains the code point U+00000, and begins at element [0] in the array,
 * which always contains 0.  If 1, the inversion list doesn't contain U+0000,
 * and it begins at element [1].  Inverting an inversion list consists of
 * adding or removing the 0 at the beginning of it.  By reserving a space for
 * that 0, inversion can be made very fast: we just flip this UV */

/* For safety, when adding new elements, remember to #undef them at the end of
 * the inversion list code section */

#define HEADER_LENGTH (INVLIST_ZERO_OFFSET + 2) /* includes 1 for the constant
                                                   0 element */

/* An element is in an inversion list iff its index is even numbered: 0, 2, 4,
 * etc */
#define ELEMENT_RANGE_MATCHES_INVLIST(i) (! ((i) & 1))
#define PREV_RANGE_MATCHES_INVLIST(i) (! ELEMENT_RANGE_MATCHES_INVLIST(i))

PERL_STATIC_INLINE STRLEN*
S__get_invlist_len_addr(pTHX_ SV* invlist)
{
    /* Return the address of the UV that contains the current number
     * of used elements in the inversion list */

    PERL_ARGS_ASSERT__GET_INVLIST_LEN_ADDR;

    return &(LvTARGLEN(invlist));
}

PERL_STATIC_INLINE UV
S__invlist_len(pTHX_ SV* const invlist)
{
    /* Returns the current number of elements stored in the inversion list's
     * array */

    PERL_ARGS_ASSERT__INVLIST_LEN;

    return *_get_invlist_len_addr(invlist);
}

PERL_STATIC_INLINE bool
S__invlist_contains_cp(pTHX_ SV* const invlist, const UV cp)
{
    /* Does <invlist> contain code point <cp> as part of the set? */

    IV index = _invlist_search(invlist, cp);

    PERL_ARGS_ASSERT__INVLIST_CONTAINS_CP;

    return index >= 0 && ELEMENT_RANGE_MATCHES_INVLIST(index);
}

#endif
