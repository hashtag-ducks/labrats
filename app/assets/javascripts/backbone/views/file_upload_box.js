Labrats.Views.AbstractFileUploadBox = Labrats.Views.AbstractBox.extend({
    events: {
        'input .file-upload-box-name': 'updateModel',
        'click .save-box': 'save'
    },

    initialize: function() {
        var tpl = $(this.templateName).text();
        this.$el.html(_.template(tpl, {
            id: this.model.get('id'),
            name: this.model.get('name')
        }));
        this.render();
    },

    render: function() {
        this.$el.find('.file-upload-box-name').val(this.model.get('name'));
    },

    updateModel: function(event) {
        event.preventDefault();
        this.model.set('name', this.$el.find('.file-upload-box-name').val());
    },

    save: function(event) {
        event.preventDefault();
        var notification = new Labrats.Views.Notification({
            message: "Saving..."
        });
        notification.show();
        this.$('form').ajaxSubmit();
    }
});
