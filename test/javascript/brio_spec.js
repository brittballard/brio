require("spec_helper.js");
require("../../public/javascripts/brio.js");

Screw.Unit(function() {
  describe("brio", function() {
    
    after(function(){ teardownFixtures() });
    
    describe("utility", function(){
      
       describe("contains utility methods for the brio applications", function(){
        
        describe("register_date_picker", function(){
          it("takes a list of div ids and runs the datepicker jQuery ui method on them", function(){
            fixture($('<div id="brittonstest" />'));

            var test_datepicker = $('#brittonstest');
            date_picker_mock = mock(test_datepicker);
            date_picker_mock.should_receive('datepicker').exactly('once');
        
            brio.utility.register_date_picker([test_datepicker]);
          });
        });
       
        describe("set_data", function(){
          it("uses the jQuery data method to store data with an element in the dom", function(){
            fixture($('<div id="brittontest" />'));
            
            brio.utility.set_data($('#brittontest'), [["mytest", 123]]);
            expect($('#brittontest').data("mytest")).to(equal, 123);
          });
        });
        
        describe("map", function(){
          var googleMapMock;
          var googleLatLngMock;
          var googleOverlay;
          
          before(function(){
            googleMapMock = Smoke.Mock();
            googleLatLngMock = Smoke.Mock();
            googleOverlay = Smoke.Mock();
          });
          
          describe("contains utility methods pertaining to google maps", function(){
            describe("initialize_map", function(){
              it("takes a lat, lng, map and pano, and an array of overlays and creates a google map", function(){
                googleMapMock = mock(new Object);
                googleLatLngMock = mock(new Object);
                googleMapMock.should_receive('setCenter').with_arguments(googleLatLngMock, 15).exactly('once');
                googleMapMock.should_receive('setUIToDefault').exactly('once');
                
                brio.utility.map.initialize_map(googleMapMock, googleLatLngMock, 15);
              });
            });
            
            describe("add_overlays", function(){
              it("adds google maps overlays passed into the method in an array to a google map", function(){
                googleMapMock = mock(new Object);
                googleMapMock.should_receive('addOverlay').with_arguments(googleOverlay).exactly('twice');

                brio.utility.map.add_overlays(googleMapMock, [googleOverlay, googleOverlay]);
              });
            });
          });
        });
        
        describe("pano", function(){
          var googleMapMock;
          var googleLatLngMock;
          var googlePanoMock;
          var googleEventMock;
          
          before(function(){
            googleMapMock = Smoke.Mock();
            googleLatLngMock = Smoke.Mock();
            googlePanoMock = Smoke.Mock();
            googleEventMock = Smoke.Mock();
          });

          describe("contains untility methods pertaining to google panos", function(){

            describe("initialize_pano", function(){
              it("initializes a new google maps pano object", function(){
                googleEventMock.should_receive('addListener').exactly('once');
                
                brio.utility.pano.initialize_pano(googleMapMock, googlePanoMock, googleEventMock);
              });
            });
            
            describe("animate", function(){
              it("should move a pano from one lat lng to another", function(){
                googlePanoMock.should_receive('getPOV').exactly('once').and_return('looking south');
                googlePanoMock.should_receive('setLocationAndPOV').with_arguments(googleLatLngMock, 'looking south').exactly('once');
                
                brio.utility.pano.animate(googleLatLngMock, googlePanoMock);
              });
            });
          });
        });
      });
    });
  });
});
