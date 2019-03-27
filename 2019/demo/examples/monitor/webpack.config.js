const path = require("path");
const webpack = require("webpack");
const merge = require("webpack-merge");

const CopyWebpackPlugin = require("copy-webpack-plugin");
const HTMLWebpackPlugin = require("html-webpack-plugin");
const CleanWebpackPlugin = require("clean-webpack-plugin");

// to extract the css as a separate file
const MiniCssExtractPlugin = require("mini-css-extract-plugin");

const GOAL = resolveGoal();
const MODE = process.env.npm_lifecycle_event === "prod" ? "production" : "development";
const filename = "index.js";

function resolveGoal() {
    if (process.env.npm_lifecycle_event === "prod") {
        return "production";
    } else if (process.env.npm_lifecycle_event === "build") {
        return "test";
    } else {
        return "development"
    }
}

const common = {
    mode: MODE,
    entry: "./src/index.js",
    output: {
        path: path.join(__dirname, "dist"),
        publicPath: "",
        // webpack -p automatically adds hash when building for production
        filename: filename
    },
    plugins: [
        new HTMLWebpackPlugin({
            // Use this template to get basic responsive meta tags
            template: "src/index.html",
            // inject details of output file at end of body
            inject: "body"
        }),
        // Copy static assets
        new CopyWebpackPlugin([
            { from: 'src/js', to: 'js' },
            { from: 'src/css', to: 'css' }
        ]),

    ],
    resolve: {
        modules: [ path.join(__dirname, "src"), "node_modules" ],
        extensions: [ ".js", ".elm", ".scss", ".png" ]
    },
    module: {
        rules: [
            {
                test: /\.js$/,
                exclude: /node_modules/,
                use: {
                    loader: "babel-loader"
                }
            },
            {
                test: /\.scss$/,
                exclude: [ /elm-stuff/, /node_modules/ ],
                // see https://github.com/webpack-contrib/css-loader#url
                loaders: [ "style-loader", "css-loader?url=false", "sass-loader" ]
            },
            {
                test: /\.css$/,
                exclude: [ /elm-stuff/, /node_modules/ ],
                loaders: [ "style-loader", "css-loader?url=false" ]
            },
            {
                test: /\.woff(2)?(\?v=[0-9]\.[0-9]\.[0-9])?$/,
                exclude: [ /elm-stuff/, /node_modules/ ],
                loader: "url-loader",
                options: {
                    limit: 10000,
                    mimetype: "application/font-woff"
                }
            },
            {
                test: /\.(ttf|eot|svg)(\?v=[0-9]\.[0-9]\.[0-9])?$/,
                exclude: [ /elm-stuff/, /node_modules/ ],
                loader: "file-loader"
            },
            {
                test: /\.(jpe?g|png|gif|svg)$/i,
                exclude: [ /elm-stuff/, /node_modules/ ],
                loader: "file-loader"
            }
        ]
    }
};

if (GOAL === "development") {
    module.exports = merge(common, {
        output: {
            path: path.join(__dirname, "dist"),
            publicPath: "/",
            // webpack -p automatically adds hash when building for production
            filename: filename
        },
        plugins: [
            // Suggested for hot-loading
            new webpack.NamedModulesPlugin(),
            // Prevents compilation errors causing the hot loader to lose state
            new webpack.NoEmitOnErrorsPlugin()
        ],
        module: {
            rules: [
                {
                    test: /\.elm$/,
                    exclude: [ /elm-stuff/, /node_modules/ ],

                    use: [
                        { loader: "elm-hot-webpack-loader" },
                        {
                            loader: "elm-webpack-loader",
                            options: {
                                // add Elm's debug overlay to output
                                debug: true,
                                forceWatch: true
                            }
                        }
                    ]

                }
            ]
        },
        devServer: {
            inline: true,
            stats: "errors-only",
            contentBase: path.join(__dirname, "dist"),
            historyApiFallback: true
        }
    });
}

if (GOAL === "test") {
    console.log("Building for Test Environment ...");
    module.exports = merge(common, {
        plugins: [
        ],
        module: {
            rules: [
                {
                    test: /\.elm$/,
                    exclude: [ /elm-stuff/, /node_modules/ ],
                    use: [
                        {
                            loader: "elm-webpack-loader",
                            options: {
                                // add Elm's debug overlay to output
                                debug: true,
                                optimize: false,
                                forceWatch: true
                            }
                        }
                    ]
                }
            ]
        }
    });
}

if (GOAL === "production") {
    console.log("Building for Production ...");
    module.exports = merge(common, {
        plugins: [
            // Delete everything from /dist directory and report to user
            new CleanWebpackPlugin([ "dist" ], {
                root: __dirname,
                exclude: [],
                verbose: true,
                dry: false
            }),
            new MiniCssExtractPlugin({
                // Options similar to the same options in webpackOptions.output
                // both options are optional
                filename: "[name]-[hash].css"
            })
        ],
        module: {
            rules: [
                {
                    test: /\.elm$/,
                    exclude: [ /elm-stuff/, /node_modules/ ],
                    use: {
                        loader: "elm-webpack-loader",
                        options: {
                            // TODO: optimize: true, requires no Debug package in code.
                            optimize: false
                        }
                    }
                },
                {
                    test: /\.css$/,
                    exclude: [ /elm-stuff/, /node_modules/ ],
                    loaders: [
                        MiniCssExtractPlugin.loader,
                        "css-loader?url=false"
                    ]
                },
                {
                    test: /\.scss$/,
                    exclude: [ /elm-stuff/, /node_modules/ ],
                    loaders: [
                        MiniCssExtractPlugin.loader,
                        "css-loader?url=false",
                        "sass-loader"
                    ]
                }
            ]
        }
    });
}
