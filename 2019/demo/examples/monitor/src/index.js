'use strict';

// console.debug in IE
(function () {
    if (typeof console.debug === 'function') {
        return false
    }
    console.debug = console.log
})();

import monitor from 'elm-monitor';
monitor();

const flags = {};
const elmNode = document.getElementById("elm-node");

const Elm = require('./Main');
const elm = Elm.Elm.Main.init({ node: elmNode, flags: flags });


