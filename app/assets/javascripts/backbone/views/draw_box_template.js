Labrats.Views.DrawBoxTemplate = Labrats.Views.AbstractDrawBox.extend({
    templateName: '#draw_box_template-tpl',

    url: function() {
        return '/box_templates/' + this.model.get('id');
    }
});
