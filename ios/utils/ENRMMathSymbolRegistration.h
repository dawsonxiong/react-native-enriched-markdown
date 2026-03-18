#pragma once

#import "ENRMFeatureFlags.h"

#if ENRICHED_MARKDOWN_MATH

#import <Foundation/Foundation.h>

/// Registers additional LaTeX symbols with iosMath's MTMathAtomFactory.
/// Safe to call multiple times; registration is guarded by dispatch_once.
void ENRMRegisterMathSymbols(void);

#endif
