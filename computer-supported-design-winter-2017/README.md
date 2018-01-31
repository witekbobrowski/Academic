# Computer Supported Design (Winter 2017)

<p align=center>
<a href="">
<img alt="" src="screens.png">
</a>
</p>
<p align=center>
<a href="https://developer.apple.com/xcode/">
<img alt="ide" src="https://img.shields.io/badge/Xcode-9-blue.svg">
</a>
<a href="https://swift.org">
<img alt="language" src="https://img.shields.io/badge/swift-4-orange.svg">
</a>
<a href="https://developer.apple.com/ios/">
<img alt="platform" src="https://img.shields.io/badge/platform-iOS%2011-green.svg">
</a>
</p>

## Assignments

Solutions for the assignments below are implemented in the ShapeGrammar iOS app. I have tried to extract the implementation of each task to separate file/class, so all the other files (classes for views, view controllers, etc.) won't be mentioned here - only the ones containing the essential logic.

- [x] 1. Shape grammar

	Create interface for generating and displaying simple shapes using the grammar defined.
	- ShapeGrammar App [`Xcode project`](ShapeGrammar/)


- [x] 2. Preference function

	Implement a function that will generate a random shape using your grammar. Next add function that will evaluate generated shape and give it a score depending on preferences.
	- ShapeGradingHelper [`swift`](ShapeGrammar/ShapeGrammar/Utils/ShapeGradingHelper.swift)


- [x] 3. Evolutionary algorithm

	An algorithm that will generate a number of sample shapes, and with the help of preference function will pick only those with the highest score to crossbreed a new generations of shapes.
	- ShapeCrossbreedingHelper [`swift`](ShapeGrammar/ShapeGrammar/Utils/ShapeCrossbreedingHelper.swift)
