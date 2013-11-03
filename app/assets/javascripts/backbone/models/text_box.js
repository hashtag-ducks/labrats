Labrats.Models.TextBox = Labrats.Models.Box.extend({
    defaults: function() {
        return _.extend(
            {content: ''}, Labrats.Models.BoxTemplate.prototype.defaults
        );
    }
});
