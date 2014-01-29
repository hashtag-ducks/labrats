describe("TabGroup model", function() {
    var tab_group;

    beforeEach(function() {
        tab_group = new Labrats.Models.TabGroup({
            id: 1,
            page_id: 1,
            boxes: [
                { ordering: 1, type: 'TextBox' },
                { ordering: 3, type: 'DrawBox' },
                { ordering: 2, type: 'TextBox' }
            ]
        }, { parse: true });
    });

    it("sorts its boxes in ascending order", function() {
        var orderings = tab_group.get('boxes').pluck('ordering');
        expect(orderings).toEqual([1, 2, 3]);
    });

    it("parses its boxes into a collection", function() {
        expect(tab_group.get('boxes').length).toEqual(3);
    });
});
