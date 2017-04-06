requires 'perl', '5.008001';

requires 'Hash::MultiValue';
requires 'Mouse::Util::TypeConstraints';

on 'test' => sub {
    requires 'Test::Deep';
    requires 'Test::More', '0.98';
};

