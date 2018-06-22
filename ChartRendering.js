// Declare variables for R input
var col = "orange";
var coord = [];
var binding = new Shiny.OutputBinding();

binding.find = function(scope) {
  return $(scope).find(".Dragable");
};

binding.renderValue = function(el, data) {
  var $el = $(el);
  var boxWidth = 600;  
  var boxHeight = 400;
  dataArray = data.data
  col = data.col
	var box = d3.select(el) 
            .append('svg')
            .attr('class', 'box')
            .attr('width', boxWidth)
            .attr('height', boxHeight);		
		var drag = d3.behavior.drag()  
        .on('dragstart', function(d, i) { 
				box.select("circle:nth-child(" + (i + 1) + ")")
				.style('fill', 'red'); 
			})
			.on('drag', function(d, i) { 
			  box.select("circle:nth-child(" + (i + 1) + ")")
				.attr('cx', d3.event.x)
				.attr('cy', d3.event.y);
			})
      .on('dragend', function(d, i) { 
				circle.style('fill', col);
				coord = []
				d3.range(1, (dataArray.length + 1)).forEach(function(entry) {
				  sel = box.select("circle:nth-child(" + (entry) + ")")
				  coord = d3.merge([coord, [sel.attr("cx"), sel.attr("cy")]])				  
				})
				console.log(coord)
        Shiny.onInputChange("JsData", coord);
			});
			
		var circle = box.selectAll('.draggableCircle')  
                .data(dataArray)
                .enter()
                .append('svg:circle')
                .attr('class', 'draggableCircle')
                .attr('cx', function(d) { return d.x; })
                .attr('cy', function(d) { return d.y; })
                .attr('r', function(d) { return d.r; })
                .call(drag)
                .style('fill', col);
};

// Regsiter new Shiny binding
Shiny.outputBindings.register(binding, "shiny.Dragable");