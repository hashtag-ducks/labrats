//= require ./text_box

Labrats.Views.TextBox = Labrats.Views.AbstractTextBox.extend({
    templateName: '#text_box-tpl',

    url: function() {
        return '/boxes/' + this.model.get('id');
    }
});
