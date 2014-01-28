describe("Box model", function() {
    var box;
    beforeEach(function() {
        box = new Labrats.Models.Box({
            id: 1,
            tab_group_id: 1,
            name: "box"
        });
    });

    it("uses the /boxes url", function() {
        expect(box.url()).toMatch(/\/boxes\/\d/);
    });

    it("isn't valid with a tab_group_id of 0", function() {
        box.set('tab_group_id', 0);
        expect(box.isValid()).toBe(false);
    });

    it("returns its attributes as a JSON representation", function() {
        expect(box.toJSON()).toEqual({
            box: {
                id: 1,
                tab_group_id: 1,
                name: "box"
            }
        });
    });
});
