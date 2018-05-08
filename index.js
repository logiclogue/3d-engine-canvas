var numjs = require("numjs");

function Point(x, y) {
    this.x = x;
    this.y = y;
}

function pointFromArray(array) {
    return new Point(array[0], array[1]);
}

function drawPoint(ctx, point) {
    ctx.moveTo(point.x, point.y);
    ctx.lineTo(point.x + 5, point.y + 5);
    ctx.stroke();
}

(function () {
    var canvas = document.getElementById("my-canvas");
    var ctx = canvas.getContext("2d");

    drawPoint(ctx, new Point(10, 10));
}());
