require "test_helper"

class UserOperationTest < Minitest::Spec

  let(:params_pass) do
    {
      firstname: 'Kelly',
      lastname: 'Slater',
      email: 'kelly@email.com',
      address1: 'unit 1',
      address2: 'pipeline street',
      city: 'Ohau',
      postcode: '1234',
      country: 'Hawaii',
      abn: '123-456'
    }
  end

  # attributes on the resulting twin, possibly overriding incoming param values.
  let(:attrs_pass) do
    {
      firstname: 'Kelly',
      lastname: 'Slater',
      email: 'kelly@email.com',
      address1: 'unit 1',
      address2: 'pipeline street',
      city: 'Ohau',
      postcode: '1234',
      country: 'Hawaii',
      abn: '123-456'
    }
  end

  it 'is successful' do
    assert_pass User::Create, {}, {}
  end

  describe 'with wrong input' do
    let(:params_pass) {{}}

    it { assert_fail User::Create, {}, [:firstname, :lastname, :email, :address2, :city, :postcode, :country, :abn] }
  end

  describe 'when wrong email format' do
    it 'shows wrong email format error' do
      assert_fail User::Create, {email: 'wrongformat.com'}, [:email] do |result|
        assert_equal({
          :email => ['Wrong format', "An account with this details already exists"],
          }, result['contract.default'].errors.messages)
      end
    end
  end

  describe 'when a user with same details already exists' do
    let(:existing_user) { User::Create.(params: params_pass) }

    it 'shows unique user error' do
      existing_user

      assert_fail User::Create, {}, [:firstname, :lastname] do |result|
        assert_equal({
          :firstname => ["An account with this details already exists"],
          :lastname => ["An account with this details already exists"],
          :email => ["An account with this details already exists"]
        }, result["contract.default"].errors.messages )
      end
    end
  end
end
