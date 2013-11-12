Labrats.Views.FileUploadBox = Labrats.Views.Box.extend({
    events: {
        'click .save-box': 'save'
    },

    initialize: function() {
        var tpl = $('#file_upload_box-tpl').text();
        this.$el.html(_.template(tpl, {
            id: this.model.get('id')
        }));
        this.render();
    },

    render: function() {
        
    },

    save: function(event) {
        event.preventDefault();
        this.$('form').ajaxSubmit();
        // debugger;
    }
});
