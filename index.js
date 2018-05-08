var numjs = require("numjs");

(function () {
    var canvas = document.getElementById("my-canvas");
    var ctx = canvas.getContext("2d");

    ctx.moveTo(0, 0);
    ctx.lineTo(200, 200);
    ctx.stroke();
}());
