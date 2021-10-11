import 'postmol.dart';

class PostHelper {
  static var posts = [
    PostMol(
        "We promote environmental protection and oppose the expansion of power plants, the abuse of pesticides, the occupation of rural land, attention to excessive consumption, urban air pollution, water pollution, reclamation and environmental management errors.",
        "Martha Gigbon",
        "15m",
        "@Friends of Earth"),
    PostMol(
        "We aim to influence, encourage and assist societies around the world, protect the integrity and diversity of nature, and ensure fairness in the use of natural resources and ecologically sustainable development ",
        "Samiur Netsy",
        "1h",
        "@IUCN"),
    PostMol(
        "Hope you can join us and protect the earth's environment together. https://www.greenpeace.org/international ",
        "Hundred Bacon",
        "4h",
        "@Greenpeace"),
    PostMol(
        "More than half the world’s GDP – 44 trillion – is highly or moderately dependent on nature. Global environmental change puts nearly 10 trillion of economic value at risk by 2050 and could result in large-scale price rises in major commodities such as timber and cotton. For example, deforestation of tropical rainforests risks creating unstable weather patterns that could drastically increase water scarcity in affected regions. Similarly, the destruction of coral reefs (e.g., via trawler fishing) displaces vital breeding grounds for the regeneration of global fish stocks.",
        "Lilian Gikandi",
        "1day",
        "@WWF:World Wildlife Fund for Nature"),
  ];

  static PostMol getTweet(int position) {
    return posts[position];
  }
}
