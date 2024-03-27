class Slider {
  int sliderId;
  String? sliderName;
  String? imageUrl;

  Slider({
    required this.sliderId,
    this.sliderName,
    this.imageUrl,
  });

  factory Slider.fromJson(Map<String, dynamic> json) {
    return Slider(
      sliderId: json['SliderId'],
      sliderName: json['SliderName'],
      imageUrl: json['ImageUrl'],
    );
  }

  Map<String, dynamic> toJson() => {
    'SliderId': sliderId,
    'SliderName': sliderName,
    'ImageUrl': imageUrl,
  };
}
