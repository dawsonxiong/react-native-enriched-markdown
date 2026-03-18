#import "ENRMMathSymbolRegistration.h"

#if ENRICHED_MARKDOWN_MATH

#import <IosMath/IosMath.h>

static void addSymbol(NSString *name, MTMathAtom *atom)
{
  static Class factory;
  static dispatch_once_t factoryToken;
  dispatch_once(&factoryToken, ^{
    factory = NSClassFromString(@"MTMathAtomFactory");
  });

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wundeclared-selector"
  SEL addSel = @selector(addLatexSymbol:value:);
  SEL opSel = @selector(operatorWithName:limits:);
#pragma clang diagnostic pop

  if ([factory respondsToSelector:addSel]) {
    typedef void (*AddFn)(id, SEL, NSString *, MTMathAtom *);
    AddFn addFn = (AddFn)[factory methodForSelector:addSel];
    addFn(factory, addSel, name, atom);
  }
}

static MTMathAtom *relation(NSString *nucleus)
{
  return [MTMathAtom atomWithType:kMTMathAtomRelation value:nucleus];
}

static MTMathAtom *largeOp(NSString *nucleus)
{
  static Class factory;
  static SEL opSel;
  static dispatch_once_t token;
  dispatch_once(&token, ^{
    factory = NSClassFromString(@"MTMathAtomFactory");
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wundeclared-selector"
    opSel = @selector(operatorWithName:limits:);
#pragma clang diagnostic pop
  });

  if ([factory respondsToSelector:opSel]) {
    typedef MTMathAtom *(*OpFn)(id, SEL, NSString *, BOOL);
    OpFn opFn = (OpFn)[factory methodForSelector:opSel];
    return opFn(factory, opSel, nucleus, NO);
  }
  return nil;
}

void ENRMRegisterMathSymbols(void)
{
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    // ── Large operators ───────────────────────────────────────
    addSymbol(@"iint", largeOp(@"\u222C"));
    addSymbol(@"iiint", largeOp(@"\u222D"));

    // ── Hooked arrows ─────────────────────────────────────────
    addSymbol(@"hookrightarrow", relation(@"\u21AA"));
    addSymbol(@"hookleftarrow", relation(@"\u21A9"));

    // ── Harpoons ──────────────────────────────────────────────
    addSymbol(@"rightharpoonup", relation(@"\u21C0"));
    addSymbol(@"rightharpoondown", relation(@"\u21C1"));
    addSymbol(@"leftharpoonup", relation(@"\u21BC"));
    addSymbol(@"leftharpoondown", relation(@"\u21BD"));
    addSymbol(@"rightleftharpoons", relation(@"\u21CC"));

    // ── Logic ─────────────────────────────────────────────────
    addSymbol(@"therefore", relation(@"\u2234"));
    addSymbol(@"because", relation(@"\u2235"));

    // ── Slanted inequalities ──────────────────────────────────
    addSymbol(@"leqslant", relation(@"\u2A7D"));
    addSymbol(@"geqslant", relation(@"\u2A7E"));

    // ── Aliases (avoid JS-side regex for these) ───────────────
    addSymbol(@"implies", relation(@"\u27F9"));
    addSymbol(@"impliedby", relation(@"\u27F8"));
    addSymbol(@"varnothing", [MTMathAtom atomWithType:kMTMathAtomOrdinary value:@"\u2205"]);
  });
}

#endif
