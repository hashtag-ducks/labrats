//= require ./draw_box

Labrats.Views.DrawBox = Labrats.Views.AbstractDrawBox.extend({
    templateName: '#draw_box-tpl',

    url: function() {
        return '/boxes/' + this.model.get('id');
    }
});
