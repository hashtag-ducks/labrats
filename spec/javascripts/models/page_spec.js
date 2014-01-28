describe("Page model", function() {
    var page;

    beforeEach(function() {
        page = new Labrats.Models.Page({
            id: 1,
            notebook_id: 1,
            tab_groups: [
                {ordering: 1},
                {ordering: 3},
                {ordering: 2}
            ]
        }, { parse: true });
    });

    it("sorts its tab groups in ascending order", function() {
        var orderings = page.get('tab_groups').pluck('ordering');
        expect(orderings).toEqual([1, 2, 3]);
    });

    it("parses its tab groups into a collection", function() {
        expect(page.get('tab_groups').length).toEqual(3);
    });
});
