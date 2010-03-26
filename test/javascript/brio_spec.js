require("spec_helper.js");
require("../../public/javascripts/brio.js");

Screw.Unit(function() {
  describe("brio", function() {
    after(function(){ teardownFixtures() });
    
    describe("utility", function(){

      describe("register_date_picker", function(){
        it("takes a list of div ids and runs the datepicker jQuery ui method on them", function(){
          fixture($('<div id="brittonstest" />'));

          var test_datepicker = $('#brittonstest');
          date_picker_mock = mock(test_datepicker);
          date_picker_mock.should_receive('datepicker').exactly('once');
        
          brio.utility.register_date_picker([test_datepicker]);
        });
        
        describe("map", function(){

          describe("initialize_map", function(){
            it("takes a lat, lng, div id for the map and pano, and an array of overlays and creates a google map", function(){

            });
          });
        });
      });
    });
  });
});

