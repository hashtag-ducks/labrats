Labrats.Views.AbstractDrawBox = Labrats.Views.AbstractBox.extend({
    events: {
        'click .clear-image': 'clearImage',
        'mousedown .draw-box-image': 'startDragging',
        'mouseup .draw-box-image': 'stopDragging',
        'mousemove .draw-box-image': 'canvasClick',
        'mouseout .draw-box-image': 'mouseOutDragging'
    },

    initialize: function() {
        var tpl = $('#draw_box-tpl').text();
        this.$el.html(_.template(tpl, {
            id: this.model.get('id'),
            name: this.model.get('name')
        }));
        var image = new Image();
        image.src = this.model.get('image');
        var canvas = this.$el.find('canvas')[0];
        canvas.getContext('2d').drawImage(image, 0, 0);
        this.render();
    },

    canvasClick: function(event) {
        if(this.isDragging) {
            var canvas = this.$el.find('canvas')[0];
            var ctx = canvas.getContext('2d');
            var x = event.offsetX,
                y = event.offsetY;
            ctx.lineWidth = 2;
            ctx.beginPath();
            ctx.moveTo(this.x, this.y);
            ctx.lineTo(x, y);
            ctx.stroke();
            this.x = x;
            this.y = y;
        }
    },

    isDragging: false,
    x: 0,
    y: 0,

    startDragging: function(event) {
        this.isDragging = true;
        this.x = event.offsetX;
        this.y = event.offsetY;
    },

    mouseOutDragging: function(event) {
        this.isDragging = false;
        this.x = event.offsetX;
        this.y = event.offsetY;
    },

    stopDragging: function(event) {
        this.isDragging = false;
        clearTimeout(this.saveTimer);
        this.saveTimer = setTimeout(_.bind(this.save, this, event), 1000);
    },

    clearImage: function(event) {
        event.preventDefault();
        var canvas = this.$el.find('canvas')[0];
        canvas.getContext('2d').clearRect(0, 0, canvas.width, canvas.height);
        this.save(event);
    },

    save: function(event) {
        event.preventDefault();
        var notification = new Labrats.Views.Notification({
            message: 'Saving...'
        });
        notification.show();
        var canvas = this.$el.find('canvas')[0];
        this.model.set('image', canvas.toDataURL('image/png'));
        this.model.save({}, {
            url: this.url()
        });
    }
});
