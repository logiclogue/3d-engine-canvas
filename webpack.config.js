const HtmlWebPackPlugin = require("html-webpack-plugin");

const htmlPlugin = new HtmlWebPackPlugin({
    template: "./index.html",
    filename: "./index.html"
});

module.exports = {
    devtool: "source-map",
    entry: "./src/Main.purs",
    module: {
        rules: [
            {
                test: /\.purs$/,
                use: {
                    loader: "purs-loader",
                    options: {
                        src: [
                            "bower_components/purescript-*/src/**/*.purs",
                            "src/**/*.purs"
                        ]
                    }
                }
            }
        ]
    },
    //plugins: [htmlPlugin]
};
