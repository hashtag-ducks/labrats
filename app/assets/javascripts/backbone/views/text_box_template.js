Labrats.Views.TextBoxTemplate = Labrats.Views.BoxTemplate.extend({
    events: {
        'input .text-box-content': 'updateModel',
        'input .text-box-name': 'updateModel'
    },

    initialize: function() {
        var tpl = $('#text_box_template-tpl').text();
        this.$el.html(_.template(tpl, {
            id: this.model.get('id'),
            content: this.model.get('content')
        }));
        this.render();
    },

    render: function() {
        this.$el.find('.text-box-content').val(this.model.get('content'));
    },

    updateModel: function(event) {
        event.preventDefault();
        this.model.set('content', this.$el.find('.text-box-content').val());
        clearTimeout(this.saveTimer);
        this.saveTimer = setTimeout(_.bind(this.save, this, event), 1000);
    }
});
