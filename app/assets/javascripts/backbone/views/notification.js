Labrats.Views.Notification = Backbone.View.extend({
    options: {
        message: '',
        shown: false,
        duration: 1500 // milliseconds
    },

    initialize: function(options) {
        this.options = _.extend({}, this.options, options);
        this.tpl = $('#notification-tpl').text();
        this.setElement($('.wrapper-notification'));
    },

    render: function() {
        // We don't want multiple notifications in the same place, so
        // we'll ensure that only one exists at a time.
        var singleton = Labrats.Views.Notification.active;
        if(singleton && singleton !== this) {
            singleton.stopListening();
            singleton.undelegateEvents();
        }
        this.$el.html(_.template(this.tpl, this.options));
        Labrats.Views.Notification.active = this;
    },

    show: function() {
        clearTimeout(this.hideTimeout);
        this.options.shown = true;
        this.shownAt = new Date();
        this.hideTimeout = setTimeout(_.bind(this.hide, this), this.options.duration);
        this.render();
    },

    hide: function() {
        // Make sure notification is shown for `this.duration`.
        if(this.shownAt && this.options.duration <= new Date() - this.shownAt) {
            this.options.shown = false;
            delete this.shownAt;
            this.render();
        }
        else {
            clearTimeout(this.hideTimeout);
            this.hideTimeout = setTimeout(
                _.bind(this.hide, this),
                this.options.duration - (new Date() - this.shownAt)
            );
        }
    }
});
