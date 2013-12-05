Labrats.Models.BoxTemplate = Backbone.Model.extend({
    url: function() {
        return '/tab_group_templates/' + this.get('tab_group_template_id') + '/box_templates';
    },

    defaults: {
        tab_group_template_id: 0,
        name: 'Text Box'
    },

    toJSON: function() {
        return {
            box_template: this.attributes
        };
    },

    validate: function(attrs) {
        if(attrs.tab_group_template_id === 0) {
            return "Tab group template ID can't be 0";
        }
    }
});
