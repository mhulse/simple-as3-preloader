## About:

Simple [AS3](http://en.wikipedia.org/wiki/ActionScript#ActionScript_3.0) swf preloader using [GreenSock's LoaderMax](http://www.greensock.com/loadermax/).

## Document Class Dependancies:

* [GreenSock's LoaderMax](http://www.greensock.com/loadermax/) library.
* My personal [AS3 utility library](https://github.com/mhulse/me.hulse.util).
* [This](http://apdevblog.com/problems-using-navigatetourl/) "navigate to URL" utility class.

Add the above packages to your [classpath](http://help.adobe.com/en_US/AS2LCR/Flash_10.0/help.html?content=00000164.html).

## Required [flashvar](http://kb2.adobe.com/cps/164/tn_16417.html)(s):

* __"swf"__
    
    Path to loaded SWF file.

## Optional [flashvar](http://kb2.adobe.com/cps/164/tn_16417.html)(s):

* __"link"__
    
    Link to visit when clicked.
    
    Default is no link.

* __"window"__
    
    * "_self" specifies the current frame in the current window.
    * "_blank" specifies a new window.
    * "_parent" specifies the parent of the current frame.
    * "_top" specifies the top-level frame in the current window.
    
    Default is _self.

* __"loader"__
    
    Hex color of loader graphic.
    
    Default is #ffffff.

## Usage example:

__Javascript (using [SWFObject](http://code.google.com/p/swfobject/)):__

    <script type="text/javascript">
        <!--
            var flashvars = {
                swf: 'child.swf',
                link: 'http://www.google.com',
                loader: '#FFFFFF',
                window: '_self'
            };
            var params = {
                scale: 'noscale',
                menu: 'false',
                bgcolor: '#000000',
                allowscriptaccess: 'always'
            };
            var attributes = {}
            swfobject.embedSWF('loader.swf', 'hd', '630px', '320px', '9.0.115.0', false, flashvars, params, attributes);
        //-->
    </script>

__HTML:__

    <div id="hd"></div>

## TODO:

* Show percent loaded.
* Make preloader graphic "grow" based on percentage loaded (currently just using looping movieclip).
* Fade out preloader graphic before showing loaded SWF.
* Make code more modular?

## Changelog:

* v1.0: __2011/05/05__
	* Initial public release.
	* Uploaded to GitHub.