grooveshark-html5
=================

An HTML5 Grooveshark client. Developed mainly out of my desire to use Grooveshark
on a non-jailbroken iOS device.

Components
----------
  - Front-end
    - CoffeeScript
    - Backbone.js
    - Zepto.js
  - Proxy for cross-domain AJAX requests to Grooveshark
    - Django

Development
-----------

    $ brew install coffee-script
    $ mkvirtualenv grooveshark-html5
    $ pip install -r requirements.txt