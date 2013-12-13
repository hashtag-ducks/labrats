Labrats.Views.OwnerNotebook = Backbone.View.extend({
    events: {
        'click .new-page': 'newPage',
        'click .grant-access': 'grantAccess',
        'click .revoke-access': 'revokeAccess',
        'mouseup .page-select button': 'selectPage',
        'click .delete-page' : 'deletePage',
        'blur #page-title': 'editPageName'
    },

    pages: [],

    selectedPage: 0,

    initialize: function() {
        var self = this;
        this.model.get('page_templates').forEach(function(page, index) {
            var ele = $('<div></div>');
            self.$el.children('div.pages').append(ele);
            var view = new Labrats.Views.PageTemplate({
                model: page,
                el: ele
            });
            self.pages.push(view);
            var tpl = '<li><button href="#" id="page-<%= index %>" class="btn btn-default"><%= name %></button></li>'
            var li = $(_.template(tpl, { index: index, name: page.get('name') }));
            self.$el.find('ul.page-select').append(li);
            var draggie = new Draggabilly(li[0], {
                containment: self.$el.find('ul.page-select')
            });
            draggie.on('dragEnd', _.bind(self.dragEnd, self));
        });
        this.render();
    },

    render: function() {
        this.$el.find('.page').hide();
        if(this.pages.length > 0) {
            var page = this.pages[this.selectedPage].model;
            $('.page-select li .btn').addClass('btn-default');
            this.$el.find('#page-' + page.get('id')).show();
            this.$el.find('#page-' + this.selectedPage).removeClass('btn-default');
            this.$el.find("#page-title").text(page.get('name'));
        }
    },

    newPage: function(event) {
        event.preventDefault();
        var page_model = new Labrats.Models.PageTemplate({
            notebook_id: this.$el.attr('id'),
            name: 'New Page'
        })
        var notification = new Labrats.Views.Notification({
            message: "Saving..."
        });
        notification.show();
        var self = this;
        page_model.save({}, {
            success: function(response) {
                // Create a new Page model so that it's got the correct ID.
                page_model = new Labrats.Models.PageTemplate(
                    _.extend({is_owner: true}, response.attributes)
                );
                var pageEle = $('<div></div>');
                self.$el.children('div.pages').append(pageEle);
                var pageView = new Labrats.Views.PageTemplate({
                    model: page_model,
                    el: pageEle
                });
                self.pages.push(pageView);
                self.selectedPage = self.pages.length - 1;
                var li = '<li><button href="#" id="page-<%= index %>" class="btn"><%= name %></button></li>'
                self.$el.find('ul.page-select').append(
                    $(_.template(li, {
                        index: self.selectedPage,
                        name: page_model.get('name')
                    }))
                );
                self.model.get('page_templates').add(page_model);
                self.render();
            },
            error: function() {
                console.log('error saving page');
            }
        });
    },

    grantAccess: function(event) {
        event.preventDefault();
        var notification = new Labrats.Views.Notification({
            message: "Saving..."
        });
        notification.show();
        var email = this.$el.find('.user-email').val();
        $.ajax('/notebook_access', {
            type: 'POST',
            data: {
                id: this.model.get('id'),
                user_email: email
            }
        });
    },

    revokeAccess: function(event) {
        event.preventDefault();
        var notification = new Labrats.Views.Notification({
            message: "Saving..."
        });
        notification.show();
        var email = this.$el.find('.user-email').val();
        $.ajax('/notebook_access/' + this.model.get('id'), {
            type: 'DELETE',
            data: {
                user_email: email
            }
        });
    },

    selectPage: function(event) {
        event.preventDefault();
        this.selectedPage = parseInt(event.currentTarget.getAttribute('id').split(/-/)[1]);
        this.render();
    },

    deletePage: function(event) {
        event.preventDefault();
        var notification = new Labrats.Views.Notification({
            message: "Deleting..."
        });
        notification.show();
        var page = this.pages[this.selectedPage];
        page.model.destroy({
            url: page.model.url() + '/' + page.model.get('id')
        });
        page.$el.remove();
        this.pages.splice(this.selectedPage, 1);
        this.$el.find('button#page-' + this.selectedPage).parent().remove();
        this.selectedPage = 0;

        var pageViews = [];
        var self = this;
        $('.page-select li').each(function(pageIndex, ele) {
            var $ele = $(ele);
            var oldIndex = parseInt(/page-(\d)/.exec($ele.find('button').attr('id'))[1]);
            var page = self.pages[pageIndex];
            if(oldIndex !== pageIndex) {
                page.model.save({ordering: pageIndex}, {
                    url: '/page_templates/' + page.model.get('id')
                });
            }
            pageViews.push(page);
            $ele.find('button').attr('id', 'page-' + pageIndex);
        });
        this.pages = pageViews;

        this.render();
    },

    editPageName: function(event) {
        var name = $(event.currentTarget).text();
        var page = this.pages[this.selectedPage].model;
        if(page.get('name') === name) { // Nothing changed
            return;
        }
        var notification = new Labrats.Views.Notification({
            message: 'Saving...'
        });
        notification.show();
        page.save({name: name}, {
            url: '/page_templates/' + page.get('id')
        });
    },

    /*
     * draggie: the Draggabilly instance
     * event: the mouseup event
     * pointer: the MouseEvent instance
     */
    dragEnd: function(draggie, event, pointer) {
        var $ele = $(draggie.element);
        var sibling = this.computeIntersection($ele);
        if(sibling !== null) {
            sibling.ele[sibling.direction]($ele);
        }
        // Everything in its right place
        $('.page-select li').css({
            top: 'auto',
            left: 'auto'
        });
        this.handleReorder();
    },

    /*
     * Actually save the reorder to the server.
     */
    handleReorder: function() {
        var pageViews = [];
        var self = this;
        var notification = new Labrats.Views.Notification({message: "Saving..."});
        $('.page-select li').each(function(pageIndex, ele) {
            var $ele = $(ele);
            var oldIndex = parseInt(/page-(\d)/.exec($ele.find('button').attr('id'))[1]);
            var page = self.pages[oldIndex];
            if(oldIndex !== pageIndex) {
                notification.show();
                page.model.save({ordering: pageIndex}, {
                    url: '/page_templates/' + page.model.get('id')
                });
            }
            pageViews.push(page);
            $ele.find('button').attr('id', 'page-' + pageIndex);
        });
        this.pages = pageViews;
    },

    computeIntersection: function($ele) {
        var left = $ele.offset().left;
        var siblings = $ele.siblings();
        // Special case 1: No siblings.
        if(siblings.length == 0) {
            return null;
        }
        // Special case 2: Trying to drag to the beginning of the list.
        if(left <= siblings.first().offset().left) {
            return {
                ele: siblings.first(),
                direction: 'before'
            }
        }
        // Special case 3: Dragging to the end of the list.
        if(left >= siblings.last().offset().left + siblings.last().width()) {
            return {
                ele: siblings.last(),
                direction: 'after'
            }
        }
        for(var i = 0; i < siblings.length; i++) {
            var $sib = $(siblings[i]);
            var offset = $sib.offset();
            if(left > offset.left && left <= $sib.width() + offset.left) {
                return {
                    ele: $sib,
                    direction: (left < offset.left + $sib.width()/2) ? 'before' : 'after'
                }
            }
        }
    }
});
