//= require ./box

Labrats.Views.Box = Labrats.Views.AbstractBox.extend({
    url: function() {
        return '/boxes/' + this.model.get('id');
    }
});
