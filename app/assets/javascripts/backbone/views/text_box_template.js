Labrats.Views.TextBoxTemplate = Labrats.Views.BoxTemplate.extend({
    events: {
        'input .text-box-content': 'updateModel',
        'input .text-box-name': 'updateModel',
        'click .save-box': 'save',
        'click .delete-box': 'delete'
    },

    initialize: function() {
        var tpl = $('#text_box_template-tpl').text();
        this.$el.html(_.template(tpl, {
            id: this.model.get('id'),
            name: this.model.get('name'),
            content: this.model.get('content')
        }));
        this.render();
    },

    render: function() {
        this.$el.find('.text-box-content').val(this.model.get('content'));
        this.$el.find('.text-box-name').val(this.model.get('name'));
    },

    updateModel: function(event) {
        event.preventDefault();
        this.model.set('content', this.$el.find('.text-box-content').val());
        this.model.set('name', this.$el.find('.text-box-name').val());
    }
});
