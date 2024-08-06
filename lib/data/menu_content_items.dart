import '../models/models.dart';

final mainMenuContent = <String>[
  'Customization',
  'Accessories',
  'Financial Services',
  'Warranty Extension',
  'Design',
  'Innovation & Excellence',
  'Sustainability',
  'History',
  'Driving Programs',
  'Lounge',
  'Club',
  'News',
  'Podcast',
];

final modelsContent = <MenuContentItem>[
  MenuContentItem(
    label: 'Ruveulto',
    generateCar: true,
  ),
  MenuContentItem(
    label: 'Urus',
    generateItems: true,
  ),
  MenuContentItem(
    label: 'Huracan',
    generateItems: true,
  ),
  MenuContentItem(
    label: 'Pre-Owned',
    url: '',
  ),
  MenuContentItem(
    label: 'Limited Series',
    generateItems: true,
  ),
  MenuContentItem(
    label: 'Concept',
    generateItems: true,
  ),
];

final dealersContent = <MenuContentItem>[
  MenuContentItem(
    label: 'Makati City',
    items: <MenuContentItem>[
      MenuContentItem(
        label: 'Automobilico',
        url: '',
      ),
      MenuContentItem(
        label: 'CATS Motors',
        url: '',
      ),
      MenuContentItem(
        label: 'Jupiter Car Exchange',
        url: '',
      ),
    ],
  ),
  MenuContentItem(
    label: 'Quezon City',
    items: <MenuContentItem>[
      MenuContentItem(
        label: 'Car Empire',
        url: '',
      ),
      MenuContentItem(
        label: 'Auto Royale',
        url: '',
      ),
      MenuContentItem(
        label: 'House of Cars',
        url: '',
      ),
      MenuContentItem(
        label: 'Bernard Auto Plus',
        url: '',
      ),
    ],
  ),
  MenuContentItem(
    label: 'Marikina City',
    items: <MenuContentItem>[
      MenuContentItem(
        label: 'Kotse Network Marikina',
        url: '',
      ),
    ],
  ),
  MenuContentItem(
    label: 'Cebu City',
    items: <MenuContentItem>[
      MenuContentItem(
        label: 'Citycar Cebu',
        url: '',
      ),
      MenuContentItem(
        label: 'Pablo Cars',
        url: '',
      ),
      MenuContentItem(
        label: 'Auto Emporium',
        url: '',
      ),
    ],
  ),
];

final servicesContent = <MenuContentItem>[
  MenuContentItem(
    label: 'Routine Maintenance',
    items: <MenuContentItem>[
      MenuContentItem(
        label: 'Oil Change',
        url: '',
      ),
      MenuContentItem(
        label: 'Filter Replacement',
        url: '',
      ),
      MenuContentItem(
        label: 'Tire Checkup',
        url: '',
      ),
      MenuContentItem(
        label: 'Headlight Checkup',
        url: '',
      ),
    ],
  ),
  MenuContentItem(
    label: 'Major Maintenance',
    items: <MenuContentItem>[
      MenuContentItem(
        label: 'Brake Inspection',
        url: '',
      ),
      MenuContentItem(
        label: 'Transmission Fluid',
        url: '',
      ),
      MenuContentItem(
        label: 'Engine Tuneup',
        url: '',
      ),
      MenuContentItem(
        label: 'Belt Replacements',
        url: '',
      ),
    ],
  ),
  MenuContentItem(
    label: 'Specialised Services',
    items: <MenuContentItem>[
      MenuContentItem(
        label: 'Battery Performance Check',
        url: '',
      ),
      MenuContentItem(
        label: 'Replace Wipers',
        url: '',
      ),
      MenuContentItem(
        label: 'Wheel Alignment',
        url: '',
      ),
      MenuContentItem(
        label: 'Aircon System Repair',
        url: '',
      ),
      MenuContentItem(
        label: 'Suspension Check',
        url: '',
      ),
    ],
  ),
];

final carrersContent = <MenuContentItem>[
  MenuContentItem(
    label: 'Office of the President',
    url: '',
  ),
  MenuContentItem(
    label: 'Corporate',
    url: '',
  ),
  MenuContentItem(
    label: 'Finance & IT',
    url: '',
  ),
  MenuContentItem(
    label: 'Manufacturing',
    url: '',
  ),
  MenuContentItem(
    label: 'Sales & Marketing',
    url: '',
  ),
  MenuContentItem(
    label: 'Aftersales',
    url: '',
  ),
  MenuContentItem(
    label: 'Internship Program',
    url: '',
  ),
];
