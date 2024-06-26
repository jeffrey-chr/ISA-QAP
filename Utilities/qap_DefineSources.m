function [sources, subsources, libsource] = qap_DefineSources()
%QAP_DEFINESOURCES List of QAP instance sources.

sources = [
    "RandomUniform", "^rou.*$|^tai.*a.*$|^xran.*$";
    "ManhattanDist", "^nug.*$|^sko.*$|^wil.*$|^had.*$|^scr.*$|^tho.*$|^stf.*m[prs].*$";
    "RealLife", "^ste.*$|^els.*$|^bur.*$|^kra.*$|^esc.*$";
    "RealLifeLike", "^tai.*b.*$|^stf.*e[prs].*|^xtab.*$";
    "Other", "^lipa.*$|^chr.*$|^tai.*c.*$|^dre.*$";
    "Palubeckis", "^xPalu.*$|^Palu.*$";
    "PaluEuclidean", "^xPaEu.*";

    "Terminal", "^term.*$";
    "TaiE", "^tai.*e.*$|^xtai.*e.*$";
    "Hypercube", "^hyp.*$";
    "QAPSAT", "^qapsat.*$"
    ];

libsource = [
    "QAPLIB", "^rou.*$|^tai.*a.*$|^nug.*$|^sko.*$|^wil.*$|^had.*$|^scr.*$|^tho.*$|^ste.*$|^els.*$|^bur.*$|^kra.*$|^esc.*$|^tai.*b.*$|^lipa.*$|^tai.*c.*$|^chr.*$"
    "reallike-gen", "^stf.*e[prs].*|^xtab.*|^stf.*m[prs].*$$"
    ];

% sources = [
%     "Palubeckis", "^Palu.*$";
%     "DreTai", "^dre.*$|^tai.*e.*$";
%     "StuFer0624", "^stf.*$";
%     "QAPLIB", "^bur.*$|^chr.*$|^els.*$|^esc.*$|^had.*$|^kra.*$|^lipa.*$|^nug.*$|^rou.*$|^scr.*$|^sko.*$|^ste.*$|^tai.*[abc].*$|^tho.*$|^wil.*$"
%            ];  

subsources = [
    "random-qaplib", "^rou.*$|^tai.*a.*$"; % Random and uniform distances and flows
    "manhat-qaplib", "^nug.*$|^sko.*$|^wil.*$|^had.*$|^scr.*$|^tho.*$"; % Distance based on grids, had is kind of weird though
    "real-qaplib", "^ste.*$|^els.*$|^bur.*$|^kra.*$|^esc.*$"; % "Real-life" problems 
    "reallike-qaplib", "^tai.*b.*$" % "Real-life-like" instances
    "other-qaplib-lipa", "^lipa.*$"; % some weird construction
    "other-qaplib-taic", "^tai.*c.*$"; % look this up later (probably grey)
	"other-qaplib-chr", "^chr.*$";
    "other-palubeckis", "^Palu.*$"; % some weird construction
    "other-gen-palubeckis", "^xPalu.*$"
    "other-gen-palueuclid", "^xPaEu.*$"
    "other-drezner", "^dre.*$";
    "taiE-bench", "^tai.*e.*$";
    "taiE-gen", "^xtai.*e.*$";
    "reallike-gen-taiBN", "^xtab.*N.*$";
    "reallike-gen-taiBT", "^xtab.*T.*$";
    "terminal-gen", "^term.*$";
    "hypercube-gen", "^hyp.*$";
    "random-gen", "^xran.*";
    "manhat-gen-SF-ran", "^stf.*mr.*$"; % Euclidean distances, random flows
    "manhat-gen-SF-str", "^stf.*ms.*$"; % Euclidean distances, structured flows
    "manhat-gen-SF-plu", "^stf.*mp.*$"; % Euclidean distances, structured flows plus
    "reallike-SF-euc-ran", "^stf.*er.*$"; % Grid distances, random flows
    "reallike-SF-euc-str", "^stf.*es.*$"; % Grid distances, structured flows
    "reallike-SF-euc-plu", "^stf.*ep.*$"; % Grid distances, structured flows plus
    "qapsat-gen-easy", "^qapsatE.*$";
    "qapsat-gen-hard", "^qapsatH.*$";
    ];

end