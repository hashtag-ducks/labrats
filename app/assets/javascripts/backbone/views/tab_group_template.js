Labrats.Views.TabGroupTemplate = Labrats.Views.TabGroup.extend({
    events: {
        'click .new-box': 'newBox',
        'click .delete-box': 'deleteBox',
        'click .delete-tab-group': 'delete',
        'click ul.boxes li': 'switch',
        'dblclick ul.boxes li a': 'editName',
        'blur a[contenteditable=true]': 'setName'
    },

    tabTemplate: '<li>' +
        '<a href="#" id=<%= type %><%= id %>><%= name %></a>' +
        '<span class="glyphicon glyphicon-remove delete-box"></span>' +
        '</li>',

    templateName: '#tab_group_template-tpl',

    childSelector: 'box_templates',

    initialize: function() {
        this.render();
        Labrats.Views.TabGroup.prototype.initialize.apply(this);
        this.$el.find("ul.boxes li").each(function() {
            $(this).addClass('inactive').removeClass('active');
        });
        var self = this;
        this.$el.find('ul.boxes li').each(function() {
            // var draggie = new Draggabilly(this, {
            //     // containment: 'ul.boxes',
            //     // axis: 'x'
            // });
            // draggie.on('dragEnd', _.bind(self.dragEnd, self));
        });
        if(this.model.get(this.childSelector).length > 0) {
            this.selectBox(this.$el.find("ul.boxes li a").first());
        }
    },

    newBox: function(event) {
        event.preventDefault();
        var type = $(event.currentTarget).data('box-type');
        var box_model = new Labrats.Models[type]({
            tab_group_template_id: this.model.get('id'),
            type: type
        });
        var self = this;
        var notification = new Labrats.Views.Notification({
            message: "Saving..."
        });
        notification.show();
        box_model.save({}, {
            success: function(response) {
                box_model = new Labrats.Models[type](
                    response.attributes
                );
                var tab = $(_.template(self.tabTemplate, {
                    type: box_model.get('type'),
                    id: box_model.get('id'),
                    name: box_model.get('name')
                }));
                var boxEle = $('<div></div>');
                self.$el.find('ul.boxes').append(tab);
                self.$el.find('ul.boxes').after(boxEle);
                var boxView = new Labrats.Views[type]({
                    model: box_model,
                    el: boxEle
                });
                boxEle.find('.box').addClass('hidden');
                self.model.get(this.childSelector).add(box_model);
                self.selectBox(tab.children('a'));
            },
            error: function() {
                console.log('error saving ' + type);
            }
        });
    },

    deleteBox: function(event) {
        event.preventDefault();
        event.stopPropagation();
        var tab = $(event.currentTarget).siblings('a');
        var parsedID = this.parseID(tab.attr('id'));
        var box = this.findBox(parseInt(parsedID[1]));
        this.model.get(this.childSelector).remove(box);
        var notification = new Labrats.Views.Notification({
            message: "Deleting..."
        });
        notification.show();
        box.destroy({
            url: box.url() + '/' + box.get('id')
        });
        tab.parent().remove();
        var type = parsedID[0].match(/[A-Z][a-z]*/g).map(function(s) { return s.toLowerCase(); }).join("-").replace(/-template/, '');
        this.$el.find('#' + type + '-' + parsedID[1]).remove();
        if(this.model.get(this.childSelector).length > 0) {
            this.selectBox(this.$el.find("ul.boxes li a").first());
        }
    },

    delete: function(event) {
        event.preventDefault();
        var notification = new Labrats.Views.Notification({
            message: "Deleting..."
        });
        notification.show();
        this.model.destroy({
            url: this.model.url() + '/' + this.model.get('id')
        });
        this.$el.remove();
    },

    editName: function(event) {
        event.preventDefault();
        var ele = $(event.currentTarget);
        ele.attr('contenteditable', 'true');
    },

    setName: function(event) {
        event.preventDefault();
        var ele = $(event.currentTarget);
        ele.attr('contenteditable', 'false');
        var text = ele.text();
        var id = parseInt(this.parseID(ele.attr('id'))[1]);
        var box = this.findBox(id);
        box.set('name', text);
        this.saveBox(box);
    },

    saveBox: function(box) {
        var notification = new Labrats.Views.Notification({
            message: "Saving..."
        });
        notification.show();
        box.save({}, {
            url: "/box_templates/" + this.model.get('id')
        });
    },

    findBox: function(id) {
        return this.model.get(this.childSelector).find(function(box) {
            return box.get('id') === id;
        });
    },

    dragEnd: function(draggie, event, pointer) {
        var ele = $(draggie.element);
        var sibling = this.findIntersection(ele);
        if(sibling) {
            sibling.before(ele);
        }
        this.handleReorder(ele);
        // Everything in its right place
        ele.css({
            top: 'auto',
            left: 'auto'
        });
    },

    /*
     * On drag/drop, find the sibling <li> that `ele` should be
     * dropped after. Returns the element, or null if it should be the
     * last one in the list.
     */
    findIntersection: function($ele) {
        var siblings = $ele.siblings();
        for(var i = 0; i < siblings.length; i++) {
            var rect = $ele[0].getBoundingClientRect(),
                siblingRect = siblings[i].getBoundingClientRect(),
                midpoint = (rect.right + rect.left)/2;
            if($ele[0] !== siblings[i] &&
                midpoint <= siblingRect.right && midpoint >= siblingRect.left) {
                return $(siblings[i]);
            }
        }
        return null;
    },

    /*
     * Correctly reorder this tab group's boxes.
     */
    handleReorder: function(ele) {
        // TODO: do
    }
});
