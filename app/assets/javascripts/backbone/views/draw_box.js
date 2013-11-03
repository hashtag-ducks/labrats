Labrats.Views.DrawBox = Labrats.Views.Box.extend({
    events: {
        'click .draw-box-image': 'canvasClick',
        'click .clear-image': 'clearImage',
        'click .save-box': 'save'
    },

    initialize: function() {
        this.render();
    },

    render: function() {
        var tpl = $('#draw_box-tpl').text();
        this.$el.html(_.template(tpl, {
            id: this.model.get('id'),
            name: this.model.get('name')
        }));
        var image = new Image();
        image.src = this.model.get('image');
        var canvas = this.$el.find('canvas')[0];
        canvas.getContext('2d').drawImage(image, 0, 0);
    },

    canvasClick: function(event) {
        var canvas = this.$el.find('canvas')[0];
        var ctx = canvas.getContext('2d');
        var x = event.offsetX;
        var y = event.offsetY;
        ctx.fillStyle = 'rgb(0, 0, 0)';
        ctx.arc(x, y, 10, 0, 2*Math.PI);
        ctx.fill();
        ctx.closePath();
    },

    clearImage: function(event) {
        event.preventDefault();
        var canvas = this.$el.find('canvas')[0];
        canvas.getContext('2d').clearRect(0, 0, canvas.width, canvas.height);
    },

    save: function(event) {
        event.preventDefault();
        var canvas = this.$el.find('canvas')[0];
        this.model.set('image', canvas.toDataURL('image/png'));
        this.model.save();
    }
});
