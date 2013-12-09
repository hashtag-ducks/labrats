Labrats.Views.TextBoxTemplate = Labrats.Views.AbstractTextBox.extend({
    templateName: '#text_box_template-tpl',

    // Multiple inheritance in Backbone models seems difficult... for
    // now I'll just have to copy/paste this
    url: function() {
        return '/box_templates/' + this.model.get('id');
    },

    events: {
        'input .text-box-content': 'updateModel',
        'click .save-box': 'save'
    }
});
