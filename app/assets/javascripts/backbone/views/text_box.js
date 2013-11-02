Labrats.Views.TextBox = Labrats.Views.Box.extend({
    events: {
        'input .text-box-content': 'updateModel',
        'click .save-box': 'save'
    },

    initialize: function() {
        var tpl = $('#text_box-tpl').text();
        this.$el.html(_.template(tpl, {
            id: this.model.get('id'),
            name: this.model.get('name'),
            content: this.model.get('content')
        }));
    },

    updateModel: function(event) {
        event.preventDefault();
        this.model.set('content', this.$el.find('.text-box-content').val());
    },

    save: function(event) {
        event.preventDefault();
        this.model.save();
    }
});
