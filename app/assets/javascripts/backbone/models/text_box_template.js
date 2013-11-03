Labrats.Models.TextBoxTemplate = Labrats.Models.BoxTemplate.extend({
    /*
     * Defaults dicts don't inherit in Backbone, so we need to
     * manually extend them from a cloned copy.
     */
    defaults: function() {
        var defaults = _.clone(Labrats.Models.BoxTemplate.prototype.defaults);
        return _.extend({
            content: ''
        }, defaults);
    }
});
