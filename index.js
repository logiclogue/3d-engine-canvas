var numjs = require("numjs");

function drawPoint(ctx, point) {
    ctx.moveTo(point[0], point[1]);
    ctx.lineTo(point[0] + 5, point[1] + 5);
    ctx.stroke();
}

function rotateX(vector, angle) {
    var cos = Math.cos(angle);
    var sin = Math.sin(angle);
    var matrix = numjs.array([
        [1, 0, 0],
        [0, cos, sin],
        [0, -sin, cos]
    ]);

    return matrix.dot(vector);
}

function rotateY(vector, angle) {
    var cos = Math.cos(angle);
    var sin = Math.sin(angle);
    var matrix = numjs.array([
        [cos, 0, -sin],
        [0, 1, 0],
        [sin, 0, cos]
    ]);

    return matrix.dot(vector);
}

function scale(vector, factor) {
    var matrix = numjs.array([
        [factor, 0, 0],
        [0, factor, 0],
        [0, 0, factor]
    ]);

    return matrix.dot(vector);
}

function rotateXY(vector, xAngle, yAngle) {
    return rotateX(rotateY(vector, yAngle), xAngle);
}

function projection(vector) {
    var projectionMatrix = numjs.array([
        [1, 0, 0],
        [0, 1, 0],
        [0, 0, 0]
    ]);

    return projectionMatrix.dot(vector);
}

(function () {
    var canvas = document.getElementById("my-canvas");
    var ctx = canvas.getContext("2d");

    var cube = numjs.array([
        [0, 0, 0],
        [0, 0, 1],
        [0, 1, 0],
        [0, 1, 1],
        [1, 0, 0],
        [1, 0, 1],
        [1, 1, 0],
        [1, 1, 1]
    ]).T;

    scale(projection(rotateXY(cube, Math.PI / 10, -Math.PI / 5)), 50).T
        .tolist()
        .forEach(function (point) {
            drawPoint(ctx, point);
        });
}());
