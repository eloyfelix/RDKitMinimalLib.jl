```@meta
CurrentModule = RDKitMinimalLib
```

```@docs
get_svg
get_rxn_svg
```

The currently supported options (`details`) are:

- `atoms`: list to specify which atoms are highlighted. Like the one provided by `get_substruct_match`
- `bonds`: list to specify which bonds are highlighted Like the one provided by `get_substruct_match`
- `width`, `height`, `offsetx`, `offsety`: used to draw in a subregion of a canvas
- `legend`: the legend drawn under the molecule
- The following [MolDrawOptions](http://rdkit.org/docs/cppapi/structRDKit_1_1MolDrawOptions.html):
    - `addAtomIndices`
    - `addBondIndices`
    - `additionalAtomLabelPadding`
    - `addStereoAnnotation`
    - `annotationFontScale`
    - `atomHighlightsAreCircles`
    - `atomLabelDeuteriumTritium`
    - `atomLabels`
    - `backgroundColour`
    - `bondLineWidth`
    - `centreMoleculesBeforeDrawing`
    - `circleAtoms`
    - `clearBackground`
    - `continuousHighlight`
    - `dummiesAreAttachments`
    - `explicitMethyl`
    - `fillHighlights`
    - `fixedBondLength`
    - `fixedScale`
    - `flagCloseContactsDist`
    - `fontFile`
    - `highlightBondWidthMultiplier`
    - `highlightColour`
    - `highlightRadius`
    - `includeAtomTags`
    - `includeMetadata`
    - `includeRadicals`
    - `legendColour`
    - `legendFontSize`
    - `maxFontSize`
    - `minFontSize`
    - `multipleBondOffset`
    - `padding`
    - `prepareMolsBeforeDrawing`
    - `rotate`
    - `scaleBondWidth`
    - `scaleHighlightBondWidth`
    - `symbolColour`
