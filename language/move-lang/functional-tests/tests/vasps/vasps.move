//! account: parent, 10000000, 0, vasp
//! account: bob, 10000000, 0, unhosted

// create a parent VASP
//! new-transaction
//! sender: association
script {
use 0x1::LBR::LBR;
use 0x1::LibraAccount;
use 0x1::LibraTimestamp;
use 0x1::VASP;
fun main(assoc: &signer) {
    let dummy_auth_key_prefix = x"00000000000000000000000000000000";
    let pubkey = x"7013b6ed7dde3cfb1251db1b04ae9cd7853470284085693590a75def645a926d";
    let add_all_currencies = false;
    LibraAccount::create_parent_vasp_account<LBR>(
        assoc, 0xA, copy dummy_auth_key_prefix, x"A1", x"A2", copy pubkey, add_all_currencies
    );

    assert(VASP::is_vasp(0xA), 2001);
    assert(VASP::is_parent(0xA), 2002);
    assert(!VASP::is_child(0xA), 2003);

    assert(VASP::parent_address(0xA) == 0xA, 2005);
    assert(VASP::compliance_public_key(0xA) == copy pubkey, 2006);
    assert(VASP::human_name(0xA) == x"A1", 2007);
    assert(VASP::base_url(0xA) == x"A2", 2008);
    assert(
        VASP::expiration_date(0xA) > LibraTimestamp::now_microseconds(),
        2009
    );

    // set up parent account as a VASP
    // TODO: remove this once //! account works
    LibraAccount::add_parent_vasp_role_from_association(
        assoc, {{parent}}, x"A1", x"A2", pubkey,
    );
}
}
// check: EXECUTED

// create a child VASP account
//! new-transaction
//! sender: parent
script {
use 0x1::LibraAccount;
use 0x1::LBR::LBR;
use 0x1::VASP;
fun main(parent_vasp: &signer) {
    let dummy_auth_key_prefix = x"00000000000000000000000000000000";
    let add_all_currencies = false;
    LibraAccount::create_child_vasp_account<LBR>(
        parent_vasp, 0xAA, dummy_auth_key_prefix, add_all_currencies
    );

    assert(VASP::parent_address(0xAA) == {{parent}}, 2010);
}
}
// check: EXECUTED

// TODO: fix this after the vasp account feature of E2E tests is fixed
// rotate a parent VASP's compliance public key
// //! new-transaction
// //! sender: parent
// script {
// use 0x1::LibraAccount;
// fun main(parent_vasp: &signer) {
//     let old_pubkey = LibraAccount::compliance_public_key({{parent}});
//     let new_pubkey = x"8013b6ed7dde3cfb1251db1b04ae9cd7853470284085693590a75def645a926d";
//     assert(old_pubkey != copy new_pubkey, 2011);
//     LibraAccount::rotate_compliance_public_key(parent_vasp, copy new_pubkey);
//     assert(LibraAccount::compliance_public_key({{parent}}) == new_pubkey, 2012);
// }
// }
// // check: EXECUTED

// getting the parent VASP address of a non-VASP should abort
//! new-transaction
//! sender: bob
script {
use 0x1::VASP;
fun main() {
    assert(VASP::parent_address({{bob}}) == {{parent}}, 2013);
}
}
// check: ABORTED
// check: 88
