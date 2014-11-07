// SimpleLineChart
// Author: Anton Petrunich
// Created On: 2014-11-07
// Based on SimplePieChart by Bradley J. Spaulding

var SimpleLineChart = {};

SimpleLineChart.initialize = function (root_element) {
    return new ViewController(root_element, {
        initialize: function () {
            this.sets = {};
            this.width = parseInt(this.root.getAttribute('width'));
            this.height = parseInt(this.root.getAttribute('height'));

            var sets = $(this.root).find('tr');
            for (var i = 0; i < sets.length; i++) {
                var set_name = $(sets[i]).find('th').html();
                this.sets[set_name] = parseInt($(sets[i]).find('td').html());
            }
            this.title = $(this.root).find('caption').html();

            this.render();
        },

        render: function () {
            $(this.root).html('');

            var img = document.createElement('img');
            img.setAttribute('width', this.width);
            img.setAttribute('height', this.height);
            img.setAttribute('src', this.image_url());

            this.root.appendChild(img);
        },

        image_url: function () {
            var url = "http://chart.googleapis.com/chart?";
            url += "cht=lc";
            url += "&chs=" + this.width + 'x' + this.height;
            url += "&chco=0000FF";
            url += "&chds=a";
            url += "&chtt=" + this.title;
            url += "&chd=t:" + this.values().join(',');
            url += "&chxl=0:|" + this.labels().join('|');
            url += "&chxt=x,y";

            return url;
        },

        values: function () {
            var result = [];
            for (var set_name in this.sets)
                result[result.length] = this.sets[set_name];
            return result;
        },

        labels: function () {
            var result = [];
            for (var set_name in this.sets)
                result[result.length] = set_name;
            return result;
        }
    })
};

$(document).ready(function () {
    $('.simple_line_chart').each(function () {
        SimpleLineChart.initialize(this);
    });
});