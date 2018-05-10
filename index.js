var mathjs = require("mathjs");

function drawPoint(ctx, point) {
    var x = point[0];
    var y = point[1];

    ctx.fillRect(x, y, 5, 5);
}

function rotateX(vector, angle) {
    var cos = Math.cos(angle);
    var sin = Math.sin(angle);
    var matrix = [
        [1, 0, 0],
        [0, cos, sin],
        [0, -sin, cos]
    ];

    return mathjs.multiply(matrix, vector);
}

function rotateY(vector, angle) {
    var cos = Math.cos(angle);
    var sin = Math.sin(angle);
    var matrix = [
        [cos, 0, -sin],
        [0, 1, 0],
        [sin, 0, cos]
    ];

    return mathjs.multiply(matrix, vector);
}

function scale(vector, factor) {
    var matrix = [
        [factor, 0, 0],
        [0, factor, 0],
        [0, 0, factor]
    ];

    return mathjs.multiply(matrix, vector);
}

function rotateXY(vector, xAngle, yAngle) {
    return rotateX(rotateY(vector, yAngle), xAngle);
}

function projection(vector) {
    var projectionMatrix = [
        [1, 0, 0],
        [0, 1, 0],
        [0, 0, 0]
    ];

    return mathjs.multiply(projectionMatrix, vector);
}

function add(matrix, vector) {
    var result = mathjs.transpose(matrix)
        .map(v => mathjs.add(v, vector));

    return mathjs.transpose(result);
}

function shiftX(vector, x) {
    var shifter = [x, 0, 0];

    return add(vector, shifter);
}

function shiftXY(vector, x, y) {
    var matrix = [x, y, 0];

    // Not implemented

    return vector;
}

(function () {
    var canvas = document.getElementById("my-canvas");
    var ctx = canvas.getContext("2d");

    var cube = mathjs.transpose([
        [0, 0, 0],
        [0, 0, 1],
        [0, 1, 0],
        [0, 1, 1],
        [1, 0, 0],
        [1, 0, 1],
        [1, 1, 0],
        [1, 1, 1]
    ]);

    var i = 0;

    setInterval(function () {
        i += 0.01;

        ctx.fillStyle = "#000000";
        ctx.fillRect(0, 0, canvas.width, canvas.height);

        ctx.fillStyle = "#FFFFFF";
        mathjs.transpose(scale(shiftX(projection(rotateXY(cube, i, i / 10)), 1, 0), 200))
            .forEach(function (point) {
                drawPoint(ctx, point);
            });
    }, 1);
}());
