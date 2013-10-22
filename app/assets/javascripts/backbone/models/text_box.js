Labrats.Models.TextBox = Labrats.Models.Box.extend({
    /*
     * Defaults dicts don't inherit in Backbone, so we need to
     * manually extend them from a cloned copy.
     */
    defaults: function() {
        var defaults = _.clone(Labrats.Models.Box.prototype.defaults);
        return _.extend({
            content: ''
        }, defaults);
    }
});
