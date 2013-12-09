Labrats.Views.AbstractTextBox = Labrats.Views.AbstractBox.extend({
    events: {
        'input .text-box-content': 'updateModel'
    },

    initialize: function() {
        var tpl = $(this.templateName).text();
        this.$el.html(_.template(tpl, {
            id: this.model.get('id'),
            name: this.model.get('name'),
            content: this.model.get('content')
        }));
    },

    updateModel: function(event) {
        event.preventDefault();
        this.model.set('content', this.$el.find('.text-box-content').val());
        clearTimeout(this.saveTimer);
        this.saveTimer = setTimeout(_.bind(this.save, this, event), 1000);
    },

    render: function() {
        this.$el.find('.text-box-content').val(this.model.get('content'));
    }
});
