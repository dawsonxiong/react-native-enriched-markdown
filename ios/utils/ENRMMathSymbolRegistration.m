#import "ENRMMathSymbolRegistration.h"

#if ENRICHED_MARKDOWN_MATH

#import <IosMath/IosMath.h>

static MTMathAtom *relation(NSString *nucleus)
{
  return [MTMathAtom atomWithType:kMTMathAtomRelation value:nucleus];
}

void ENRMRegisterMathSymbols(void)
{
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    // ── Large operators ───────────────────────────────────────
    [MTMathAtomFactory addLatexSymbol:@"iint"
                                value:[MTMathAtomFactory operatorWithName:@"\u222C" limits:NO]];
    [MTMathAtomFactory addLatexSymbol:@"iiint"
                                value:[MTMathAtomFactory operatorWithName:@"\u222D" limits:NO]];

    // ── Hooked arrows ─────────────────────────────────────────
    [MTMathAtomFactory addLatexSymbol:@"hookrightarrow" value:relation(@"\u21AA")];
    [MTMathAtomFactory addLatexSymbol:@"hookleftarrow" value:relation(@"\u21A9")];

    // ── Harpoons ──────────────────────────────────────────────
    [MTMathAtomFactory addLatexSymbol:@"rightharpoonup" value:relation(@"\u21C0")];
    [MTMathAtomFactory addLatexSymbol:@"rightharpoondown" value:relation(@"\u21C1")];
    [MTMathAtomFactory addLatexSymbol:@"leftharpoonup" value:relation(@"\u21BC")];
    [MTMathAtomFactory addLatexSymbol:@"leftharpoondown" value:relation(@"\u21BD")];
    [MTMathAtomFactory addLatexSymbol:@"rightleftharpoons" value:relation(@"\u21CC")];

    // ── Logic ─────────────────────────────────────────────────
    [MTMathAtomFactory addLatexSymbol:@"therefore" value:relation(@"\u2234")];
    [MTMathAtomFactory addLatexSymbol:@"because" value:relation(@"\u2235")];

    // ── Slanted inequalities ──────────────────────────────────
    [MTMathAtomFactory addLatexSymbol:@"leqslant" value:relation(@"\u2A7D")];
    [MTMathAtomFactory addLatexSymbol:@"geqslant" value:relation(@"\u2A7E")];

    // ── Aliases (avoid JS-side regex for these) ───────────────
    [MTMathAtomFactory addLatexSymbol:@"implies" value:relation(@"\u27F9")];
    [MTMathAtomFactory addLatexSymbol:@"impliedby" value:relation(@"\u27F8")];
    [MTMathAtomFactory addLatexSymbol:@"varnothing"
                                value:[MTMathAtom atomWithType:kMTMathAtomOrdinary value:@"\u2205"]];
  });
}

#endif
