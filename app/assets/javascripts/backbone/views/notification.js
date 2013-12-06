Labrats.Views.Notification = Backbone.View.extend({
    options: {
        message: '',
        shown: false,
        duration: 1000 // milliseconds
    },

    initialize: function(options) {
        this.options = options;
        this.tpl = $('#notification-tpl').text();
        this.setElement($('.wrapper-notification'));
    },

    render: function() {
        this.$el.html(_.template(this.tpl, this.options));
    },

    show: function() {
        clearTimeout(this.hideTimeout);
        this.options.shown = true;
        this.shownAt = new Date();
        this.hideTimeout = setTimeout(_.bind(this.hide, this), this.duration);
        this.render();
    },

    hide: function() {
        clearTimeout(this.hideTimeout);
        this.options.shown = false;
        this.render();
    }
});
