const { environment } = require('@rails/webpacker')

const webpack = require('webpack')

environment.plugins.append(
    'Provide',
    new webpack.ProvidePlugin({
        $: 'jquery/dist/jquery.js',
        jQuery: 'jquery/dist/jquery.js',
        Popper: ['popper.js', 'default']
    })
)

module.exports = environment
