Labrats.Views.DrawBoxTemplate = Labrats.Views.BoxTemplate.extend({
    events: {
        'input .draw-box-name': 'updateModel',
        'click .save-box': 'save'
    },

    updateModel: function(event) {
        this.model.set('name', this.$el.find('.draw-box-name').val());
    },

    initialize: function() {
        var tpl = $('#draw_box_template-tpl').text();
        this.$el.html(_.template(tpl, {
            id: this.model.get('id'),
            name: this.model.get('name')
        }));
        this.render();
    }
});
