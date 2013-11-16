Labrats.Views.FileUploadBoxTemplate = Labrats.Views.BoxTemplate.extend({
    events: {
        'input .file-upload-box-name': 'updateModel',
        'click .save-box': 'save'
    },

    initialize: function() {
        var tpl = $('#file_upload_box_template-tpl').text();
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
    }
});
