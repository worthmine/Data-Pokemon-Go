requires 'perl', '5.008001';
requires 'YAML::XS', '0.66';
requires 'Text::CSV::XS', '1.34';

on 'test' => sub {
    requires 'Test::More', '1.302';
};

